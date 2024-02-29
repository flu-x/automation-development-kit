"""
Author: @Corefinder89
Language: Python
Copyrights: Soumyajit Basu
Purpose: Get the operating system type based on linux, windows or macos
"""
import platform
import sys

class OStype:

    LINUX = "linux"
    MAC = "macos"
    WIN = "windows"

    # Get the required OS name
    def osname(self):
        pl = sys.platform
        if "linux" in pl:
            return OStype.LINUX
        if pl == "darwin":
            return OStype.MAC
        if pl == "windows":
            return OStype.WIN

    # Get OS architecture type
    def osarchitecture(self):
        arch = platform.machine()
        if arch.endswith('64'):
            return 64
        else:
            return 32

    # Get the required OS type
    def ostype(self):
        return OStype.osname(self) + str(OStype.osarchitecture(self))