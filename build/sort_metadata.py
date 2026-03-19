# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import glob


def sort_yaml_arrays(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    out = []
    i = 0
    while i < len(lines):
        line = lines[i]
        out.append(line)

        # Sort roles array
        if line.rstrip() == "        roles:":
            roles = []
            i += 1
            while i < len(lines) and lines[i].startswith("          - "):
                roles.append(lines[i])
                i += 1
            roles.sort()
            out.extend(roles)
            continue

        # Sort services array
        if line.rstrip() == "    services:":
            services = []
            i += 1
            while i < len(lines) and lines[i].startswith("      - "):
                services.append(lines[i])
                i += 1
            services.sort()
            out.extend(services)
            continue

        i += 1

    with open(file_path, 'w') as f:
        f.writelines(out)


for filename in glob.glob('**/metadata.yaml', recursive=True):
    sort_yaml_arrays(filename)
