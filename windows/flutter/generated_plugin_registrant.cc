//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <flutter_pos_printer_platform/flutter_pos_printer_platform_plugin.h>
#include <nb_utils/nb_utils_plugin.h>
#include <network_info_plus_windows/network_info_plus_windows_plugin.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FlutterPosPrinterPlatformPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterPosPrinterPlatformPlugin"));
  NbUtilsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NbUtilsPlugin"));
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
