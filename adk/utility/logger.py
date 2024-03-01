import logging


class Logger(object):
    logging.basicConfig(level=logging.INFO)

    # logging for information
    def log_info(self, information_message):
        logging.info(information_message)

    # logging for error
    def log_error(self, error_message):
        logging.error(error_message)

    # logging for debugging
    def log_debug(self, debug_message):
        logging.debug(debug_message)

    # logging for warning
    def log_warning(self, warning_message):
        logging.warning(warning_message)

    # logging for critical
    def log_critical(self, critical_message):
        logging.critical(critical_message)