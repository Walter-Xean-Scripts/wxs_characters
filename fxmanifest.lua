fx_version 'cerulean'
games { 'gta5' }

author 'Walter & Xean'
description 'A new FiveM framework - soon compatible with ESX & QBCore scripts'
version '1.0.0'

lua54 'yes'

shared_scripts {
    "@wxs_core/main.lua",
    "@wxs_framework/imports/main.lua"
}
client_script "client.lua"
server_script "server.lua"

files {
    "uis/*.lua",
    "images/*.png"
}

dependencies {
    "wxs_core",
    "wxs_framework"
}
