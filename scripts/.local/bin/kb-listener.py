#!/usr/bin/env python3

import os
import pyudev
import subprocess


def main():
    context = pyudev.Context()
    monitor = pyudev.Monitor.from_netlink(context)
    monitor.filter_by(subsystem="input")
    monitor.start()

    for device in iter(monitor.poll, None):
        dev_product = device.get("PRODUCT")
        dev_name = device.get("NAME")
        if dev_name:
            dev_name = dev_name.replace('"', "").replace('"', "")

        if not (
            dev_name == "Corne-ish Zen Keyboard" and dev_product == "5/1d50/615e/1"
        ):
            continue

        home = os.getenv("HOME")
        if not home:
            return

        switcher_script = [f"{home}/.local/bin/kb-layout-switcher"]

        action = device.get("ACTION")
        if action == "remove":
            switcher_script.append("dvorak")

        if action in ["remove", "add"]:
            subprocess.call(switcher_script)
            print(f"{action} triggered: script called with: {switcher_script}")


if __name__ == "__main__":
    main()
