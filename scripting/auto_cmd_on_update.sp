#include <sourcemod>
#include <SteamWorks>

#include <multicolors>

#define PLUGIN_VERSION "1.0.0"

ConVar g_cvCommand = null;
ConVar g_cvWarnTime = null;
ConVar g_cvVersion = null;

int g_iCountDown = 0;

public Plugin myinfo = 
{
    name = "Auto Command On Update",
    author = "Christian Deacon",
    description = "Executes a command when a game update is detected.",
    version = PLUGIN_VERSION,
    url = "moddingcommunity.com"
};

public void OnPluginStart()
{
    g_cvCommand = CreateConVar("sm_acou_command", "quit", "The command to execute when a game update is detected.");
    g_cvWarnTime = CreateConVar("sm_acou_warn_time", "10", "Warning time in seconds before command is executed when an update is detected.");
    g_cvVersion = CreateConVar("sm_acou_version", PLUGIN_VERSION, "Current version of plugin.");

    RegAdminCmd("sm_acou_print_version", Command_Version, ADMFLAG_ROOT);
    RegAdminCmd("sm_acou_test", Command_Test, ADMFLAG_ROOT);

    LoadTranslations("acou.phrases");

    AutoExecConfig(true, "acou.plugin");
}

public Action Command_Version(int iClient, int iArgs)
{
    // Retrieve version from CVAR.
    char sVersion[MAX_NAME_LENGTH];
    GetConVarString(g_cvVersion, sVersion, sizeof(sVersion));

    PrintToServer("[ACOU] Version %s", sVersion);

    return Plugin_Handled;
}

public Action Command_Test(int iClient, int iArgs)
{
    CReplyToCommand(iClient, "%t%t", "Tag", "TestReply");

    UpdateDetected();

    return Plugin_Handled;
}

public Action SteamWorks_RestartRequested()
{
    UpdateDetected();
}

public Action Timer_Warning(Handle hTimer)
{
    // Check if we should execute the command and stop this timer.
    if (g_iCountDown >= g_cvWarnTime.IntValue)
    {
        ExecCmd();

        return Plugin_Stop;
    }

    CPrintToChatAll("%t%t", "Tag", "WarnMsg", (g_cvWarnTime.IntValue - g_iCountDown));

    g_iCountDown++;

    return Plugin_Continue;
}

stock void UpdateDetected()
{
    // Check if we have warning time.
    if (g_cvWarnTime.IntValue > 0)
    {
        CreateTimer(1.0, Timer_Warning, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
    }
    else
    {
        ExecCmd();
    }
}

stock void ExecCmd()
{
    char sCmd[256];
    GetConVarString(g_cvCommand, sCmd, sizeof(sCmd));

    ServerCommand(sCmd);
}