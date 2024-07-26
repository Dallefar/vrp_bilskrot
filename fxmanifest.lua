fx_version 'cerulean'
games 'gta5'
dependency "vrp"
lua54 'yes'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }
client_scripts { "client/Proxy.lua", "client/main.lua" }
server_scripts { "@vrp/lib/utils.lua", "server/main.lua" }