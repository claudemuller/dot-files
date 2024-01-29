#!/usr/bin/env python3

import pyudev
import subprocess


def main():
    context = pyudev.Context()
    monitor = pyudev.Monitor.from_netlink(context)
    monitor.filter_by(subsystem="input")
    monitor.start()

    for device in iter(monitor.poll, None):
        dev_name = device.get("NAME")
        if dev_name:
            dev_name = dev_name.replace('"', "").replace('"', "")

        dev_product = device.get("PRODUCT")

        if dev_name == "Corne-ish Zen Keyboard" and dev_product == "5/1d50/615e/1":
            switcher_script = ["/home/lukefilewalker/.local/bin/kb-layout-switcher"]

            action = device.get("ACTION")
            if action == "remove":
                switcher_script.append("dvorak")

            subprocess.call(switcher_script)


if __name__ == "__main__":
    main()
