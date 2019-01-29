import json


class Py3status:
    def read_ss_server(self):
        f = json.loads(open("/etc/shadowsocksrr/config.json", "r").read())
        return {
                "full_text": "  {} ".format(f["remarks"])
                }

