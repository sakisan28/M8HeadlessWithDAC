#!/usr/bin/bash
sed -i 's/gamepad_opt=1/gamepad_opt=0/' /storage/.local/share/m8c/config.ini
sed -i 's/gamepad_edit=0/gamepad_edit=1/' /storage/.local/share/m8c/config.ini
