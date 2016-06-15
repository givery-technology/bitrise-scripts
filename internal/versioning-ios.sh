#!/bin/bash

commitDate=$(git log -1 --format='%ci')
comps=(`echo $commitDate | sed -e 's/[^0-9]/ /g'`)

y=$(( ${comps[0]} - 2000 ))
m_d=(`echo ${comps[1]}${comps[2]} | sed 's/^0*//'`)
h_m_s=(`echo ${comps[3]}${comps[4]}${comps[5]} | sed 's/^0*//'`)

version=$y.$m_d.$h_m_s

agvtool new-version -all $version
