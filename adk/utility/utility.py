from adk.utility.logger import Logger

import os
import stat
import json

class Utility(object):

    def __init__(self):
        self.log = Logger()
    def read_config(self, p_element, c_element):
        with open("../configurations/config.json", "r") as jsonobj:
            jsondata = json.load(jsonobj)
            json_obj = jsondata.get(p_element).get(c_element)

        return json_obj

    def set_executable_permissions(self, installation_type="macinstallationscript"):
        file_path=""

        if installation_type == "macinstallationscript":
            file_path = self.read_config("file_path", "mac_installation")
        if installation_type == "linuxinstallationscript":
            file_path = self.read_config("file_path", "linux_installation")

        st = os.stat(file_path)
        os.chmod(file_path, st.st_mode | stat.S_IEXEC)

        self.log.log_info("---- Permission set on %s ----" % type)