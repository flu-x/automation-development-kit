from adk.utility.ostype import OStype
from adk.utility.utility import Utility
from adk.utility.logger import Logger
import subprocess

class Installer(object):
    def __init__(self):
        self.ostype = OStype()
        self.ut = Utility()
        self.log = Logger()

    def install_dependency(self):
        os_type = self.ostype.osname()

        if os_type == "macos":
            self.ut.set_executable_permissions()
            subprocess.call('../scripts/./checkinstallermac.sh')
        if os_type == "linux":
            self.ut.set_executable_permissions("linuxinstallationscript")
            subprocess.call('../scripts/./checkinstallerlinux.sh')
