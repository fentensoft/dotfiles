import json
import subprocess
import re
import threading
import requests
import base64
import pick


def d(s):
    if isinstance(s, bytes):
        s = s.decode("UTF-8")
    res = base64.b64decode(s.replace("_", "/").replace("-", "+") + "==")
    if isinstance(res, bytes):
        res = res.decode("UTF-8")
    return res


class SSR_parser(object):
    def __init__(self, url, config_file, supervisor_program, proxy = ""):
        self.url = url
        self.config_file = config_file
        self.supervisor_program = supervisor_program
        self.proxy = ""
        self.lock = threading.Lock()
        self.servers = []

    def do(self):
        f = open(self.config_file, "r")
        try:
            print("\033[1mCurrent server:\033[0m  \033[34m{data[remarks]} {data[server]}\033[0m".format(data=json.loads(f.read())))
        except:
            print("\033[31mCannot get current server remark\033[0m")
        f.close()
        print("\033[1mGetting server list\033[0m")
        try:
            tmp_server = self.parse_url()
            tasks = []
            print("\033[1mPinging servers\033[0m")
            for server in tmp_server:
                trd = threading.Thread(target=self.ping, args=(server,))
                trd.start()
                tasks.append(trd)
            for task in tasks:
                task.join()
            self.servers = sorted(self.servers, key=lambda l: float(l["ping"]))
            selected = pick.pick(list(map(lambda line: line["remarks"].ljust(15) + str(line["ping"]), self.servers)))
            print("\033[34m{}\033[0m \033[1mselected\033[0m".format(self.servers[selected[1]]["remarks"]))
            conf = self.servers[selected[1]]
            del conf["ping"]
            conf["local_port"] = "1080"
            conf["timeout"] = "60"
            if "obfsparam" in conf:
                conf["obfs_param"] = conf.pop("obfsparam")
            f = open(self.config_file, "w")
            f.write(json.dumps(conf, ensure_ascii=False))
            f.close()
            subprocess.call(["supervisorctl", "restart", self.supervisor_program])
        except KeyboardInterrupt:
            print("\033[31mUser cancelled\033[0m")

    def parse_url(self):
        if self.proxy:
            proxies = {
                "http": self.proxy,
                "https": self.proxy
            }
            r = requests.get(self.url, proxies=proxies)
        else:
            r = requests.get(self.url)
        links = d(r.text).split()
        result = []
        for link in links:
            server = d(link[6:len(link)]).split("/?")
            tmp = server[0].split(":")
            res = {}
            res["server"] = tmp[0]
            res["server_port"] = tmp[1]
            res["protocol"] = tmp[2]
            res["method"] = tmp[3]
            res["obfs"] = tmp[4]
            res["password"] = d(tmp[5])
            for param in server[1].split("&"):
                tmp0 = param.split("=")
                res[tmp0[0]] = d(tmp0[1])
            result.append(res)
        return result

    def ping(self, server):
        p = subprocess.Popen("ping -W1 -c4 -i0.2 {}".format(server["server"]),
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             shell=True)
        if p.wait() == 0:
            result = p.stdout.read().decode("utf-8")
            ret = re.findall(r"\d+\.\d+/\d+\.\d+/\d+\.\d+/\d+\.\d+", result)[0].split("/")[1]
        else:
            ret = 999
        server["ping"] = ret
        self.lock.acquire()
        self.servers.append(server)
        self.lock.release()

tmp = SSR_parser("url_here", "config_file_here", "supervisor_program_name_here", "proxy_here")
tmp.do()
