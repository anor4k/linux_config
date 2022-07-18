import argparse
import subprocess
from pathlib import Path
from urllib.request import urlretrieve

SCRIPTS = [
    # SOURCE: https://github.com/mpv-player/mpv/tree/master/TOOLS/lua
    'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/acompressor.lua',
    'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autocrop.lua',
    'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua',
    'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/status-line.lua',
    # SOURCE: https://github.com/cyl0/MordenX
    'https://raw.githubusercontent.com/cyl0/MordenX/main/mordenx.lua',
    # SOURCE: https://github.com/CogentRedTester/mpv-scripts
    'https://github.com/CogentRedTester/mpv-scripts/raw/master/cycle-commands.lua',
    'https://github.com/CogentRedTester/mpv-scripts/raw/master/cycle-profile.lua',
    # SOURCE: https://github.com/mpv-player/mpv/tree/master/player/lua
    'https://github.com/mpv-player/mpv/blob/master/player/lua/auto_profiles.lua',
    # SOURCE: https://github.com/rossy/mpv-repl
    'https://github.com/rossy/mpv-repl/raw/master/repl.lua',
    # SOURCE: https://github.com/ekisu/mpv-webm
    'https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua'
]

SIMLINKS = ['mpv.conf', 'input.conf', 'script-opts', 'shaders']

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Configure mpv, downloading scripts and linking configs')
    parser.add_argument('config_path', default='~/.config/mpv', nargs='?')
    args = parser.parse_args()

    mpv_config = Path(args.config_path).expanduser().resolve()
    mpv_scripts = mpv_config / 'scripts'
    mpv_scripts.mkdir(parents=True, exist_ok=True)

    print("Downloading and installing mpv scripts")
    print("mpv config directory: ", mpv_config)

    # download scripts
    for url in SCRIPTS:
        filename = url.split('/')[-1]
        dest = mpv_scripts / filename
        print(f"Downloading {filename} from {url}...")
        urlretrieve(url, dest)
        print(f"Saved {filename} to {dest}")

    print("Finished downloading scripts")

    for link in SIMLINKS:
        dest = mpv_config / link
        subprocess.call(['ln', '-sf', str(Path(link).resolve()), str(dest)])
        print(f'Linked {link} to {dest}')
