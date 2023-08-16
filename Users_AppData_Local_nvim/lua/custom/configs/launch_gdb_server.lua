local fichier_config = vim.fn.getcwd().."/dap_conf.txt"

local function trim(s)
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

local function lire_fichier_config(chemin_fichier)
    local variables = {}
        for ligne in io.lines(chemin_fichier) do
            local nom_variable, valeur = ligne:match("([^=]+)=(.*)")
            if nom_variable and valeur then
              variables[trim(nom_variable)] = trim(valeur)
            end
        end
        return variables
 end

 -- Appel de la fonction pour lire le fichier
 local configuration = lire_fichier_config(fichier_config)

 -- Maintenant, vous pouvez accéder aux valeurs à l'aide des noms de variable
exec_name = configuration.exec_name
server_bin_path = configuration.server_bin_path
local_bin_path = configuration.local_bin_path
gdb_path = configuration.gdb_path

os.execute(gdb_path.."gdbserver.exe 127.0.0.1:2000 "..server_bin_path..exec_name.." & ")
vim.wait(500)
