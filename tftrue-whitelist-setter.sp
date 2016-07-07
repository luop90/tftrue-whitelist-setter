#pragma semicolon 1

#include <sourcemod>

#define PLUGIN_VERSION "1.0"

public Plugin:myinfo = {
  "name": "TFTrue Whitelist Setter",
  "author": "Luop90",
  "description": "Based on player count (or command), sets the TFTrue whitelist ID to the correct whitelist",
  "version": PLUGIN_VERSION,
  "url": "https://github.com/luop90"
};

new Handle: cvarVersion;

public OnPluginStart() {
  cvarVersion = CreateConVar("tftrue_whitelist_setter_version", PLUGIN_VERSION, "Version of the plugin.");

  AddCommandListener(ManuallySetWhitelist, "sm_setwhitelist");
}
