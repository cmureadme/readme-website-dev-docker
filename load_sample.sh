#!/bin/bash

set -e

remote='https://cmureadme.com/sample_dbs/'
local='sample_dbs'

mkdir -p "${local}"

samples_index=$(curl -s "${remote}" | grep -Po '<a href=".*">\K[a-zA-Z0-9_\-.]+(?=\.tar</a>)')
count="${#samples_index[@]}"

if [[ "$count" -eq 0 ]]; then
    printf 'No files found using <a href=".*">\K[a-zA-Z0-9_\-.]+(?=\.tar</a>) on %s\n' "${remote}" >&2

    exit 1
fi

printf "Choose sample:\n"
for i in "${!samples_index[@]}"; do
    printf "%s: %s\n" "${i}" "${samples_index[${i}]}"
done

read -p "(0) " choice
choice=${choice:-0}

if ((choice >= 0 && choice < count)); then
    sample="${samples_index[${choice}]}"
else
    printf "Invalid index: '%s'\n" "${choice}"
    exit 1
fi

printf '\n'

if [[ -e "${local}/${sample}" ]]; then
    old_index='0'

    while [[ -e "${local}/${sample}-old${old_index}" ]]; do
        old_index=$((old_index+1))
    done

    mv "${local}/${sample}" "${local}/${sample}-old${old_index}"

    printf 'Moved %s to %s\n\n' "${local}/${sample}" "${local}/${sample}-old${old_index}"
fi

curl -O --output-dir "${local}" "${remote}/${sample}.tar"

cd "${local}"

printf '\nUntarring:\n'
tar xvf "${sample}.tar"
rm "${sample}.tar"
