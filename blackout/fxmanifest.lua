fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'PixoVoid'
description 'Secure and optimized Blackout Script for FiveM with ESX Framework'
version '1.0.0'

dependencies {
    'es_extended'
}

shared_scripts {
    'config.lua'
}

server_scripts {    
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}