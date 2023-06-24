import json
import os

VENTOY_PATH = "/path/to/ventoy"  # Update with the actual path to Ventoy

def is_ventoy_installed():
    """Checks if Ventoy is installed on the system."""
    return os.path.exists(VENTOY_PATH)

def install_plugin(plugin_name):
    """Installs a Ventoy plugin."""
    if not is_ventoy_installed():
        print("Ventoy is not installed.")
        return

    plugin_path = os.path.join("plugins", plugin_name + ".py")
    if not os.path.exists(plugin_path):
        print("Plugin not found: " + plugin_name)
        return

    print("Installing plugin: " + plugin_name)
    os.system("cp " + plugin_path + " plugins")

def use_plugin(plugin_name):
    """Uses a Ventoy plugin."""
    if not is_ventoy_installed():
        print("Ventoy is not installed.")
        return

    ventoy_json_path = "ventoy.json"
    if not os.path.exists(ventoy_json_path):
        print("Ventoy configuration file not found.")
        return

    with open(ventoy_json_path, "r") as f:
        data = json.load(f)

    plugins = data["plugins"]
    if plugin_name not in plugins:
        print("Plugin not enabled: " + plugin_name)
        return

    print("Using plugin: " + plugin_name)
    data["plugins"] = [plugin_name]

    with open(ventoy_json_path, "w") as f:
        json.dump(data, f)

def install_ventoy():
    """Installs Ventoy."""
    print("Installing Ventoy...")
    url = "https://github.com/ventoy/Ventoy/releases/download/v1.0.92/Ventoy.zip"
    filename = "Ventoy.zip"
    os.system("wget " + url + " -O " + filename)
    os.system("unzip " + filename)
    os.system("sudo mv Ventoy2Disk.* /usr/bin")

def main():
    """Main function."""
    print("Ventoy plugin installer")

    if not is_ventoy_installed():
        install_ventoy()

    plugin_name = input("Enter the name of the plugin to install: ")
    install_plugin(plugin_name)

    plugin_name = input("Enter the name of the plugin to use: ")
    use_plugin(plugin_name)

if __name__ == "__main__":
    main()
