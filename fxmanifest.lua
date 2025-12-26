fx_version 'cerulean'
name 'aura_mapanim'
games { 'gta5' }
lua54 'yes'

author 'Aura Development'
description 'A script for handling map animations when the pause menu is active.'
version '1.1'

shared_script '@ox_lib/init.lua'

client_scripts {
    'shared/config.lua',
    'client/main.lua' 
}
