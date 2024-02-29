from adk.utility.ostype import OStype
import subprocess

class Installer(object):
    def __init__(self):
        self.ostype = OStype()

    def install_dependency_mac(self):
        os_type = self.ostype.osname()

        if os_type == "macos":
            exit_code = subprocess.call('../scripts/./checkinstallermac.sh')
            print(exit_code)

i=Installer()
i.install_dependency_mac()