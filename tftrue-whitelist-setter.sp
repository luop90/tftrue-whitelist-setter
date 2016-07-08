#pragma semicolon 1

#include <sourcemod>

#define PLUGIN_VERSION "1.1"

public Plugin:myinfo = {
  name = "TFTrue Whitelist Setter",
  author = "Luop90",
  description = "Based on player count (or command), sets the TFTrue whitelist ID to the correct whitelist",
  version = PLUGIN_VERSION,
  url = "https://github.com/luop90"
};

new Handle: cvarVersion;
new WHITELISTID_4S = 5171;
new WHITELISTID_6S = 5188;
new WHITELISTID_HL = 5823;
new WHITELISTID_ULTIDUO = 4960;

public OnPluginStart() {
  cvarVersion = CreateConVar("tftrue_whitelist_setter_version", PLUGIN_VERSION, "Version of the plugin");
  HookConVarChange(cvarVersion, OnVersionChanged);

  RegConsoleCmd("sm_setwhitelist", ManuallySetWhitelist, "Change whitelist to correct id");
}

public OnVersionChanged(Handle: cvar, const String: oldVal[], const String: newVal[]) {
	if (!StrEqual(newVal, PLUGIN_VERSION, false)) {
		SetConVarString(cvarVersion, PLUGIN_VERSION);
		PrintToServer("\x05[TFTrue]\x01 Version changed back to %s", PLUGIN_VERSION);
	}
}

public Action:ManuallySetWhitelist(client, args) {
  new String:name[20];

  GetCmdArgString(name, sizeof(name));

  if (!CheckCommandAccess(client, "admin", ADMFLAG_GENERIC, false)) {
    PrintToChat(client, "\x05[TFTrue]\x01 You do not have permission to use this command");
    return Plugin_Handled;
  }

  if (strlen(name) < 1) {
    PrintToChat(client, "\x05[TFTrue]\x01 Usage: sm_setwhitelist [UltiDuo|4s|6s|HL]");
    return Plugin_Handled;
  }

  // I wish SourcePawn had switch statements...
  if (StrEqual(name, "4s", false)) {
    ChangeWhitelistId(WHITELISTID_4S);
  } else if (StrEqual(name, "6s", false)) {
    ChangeWhitelistId(WHITELISTID_6S);
  } else if (StrEqual(name, "HL", false)) {
    ChangeWhitelistId(WHITELISTID_HL);
  } else if (StrEqual(name, "Ultiduo", false)) {
    ChangeWhitelistId(WHITELISTID_ULTIDUO);
  } else {
    PrintToChat(client, "\x05[TFTrue]\x01 Unknown whitelist type %s", name);
  }

  return Plugin_Handled;
}

stock ChangeWhitelistId(id) {
  ServerCommand("tftrue_whitelist_id %i", id);

  PrintToChatAll("\x05[TFTrue]\x01 Set whitelist id to %i", id);
}
