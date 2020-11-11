
import toml
import sys

assert len(sys.argv) == 3

_, toml_file, version_str = sys.argv

with open(toml_file, "r") as f:
    data = toml.load(f)

data["project"]["version"] = version_str

with open(toml_file, "w") as f:
    toml.dump(data, f)
