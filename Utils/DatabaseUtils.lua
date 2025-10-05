---@class AddonPrivate
local Private = select(2, ...)

---@class DatabaseUtils
local databaseUtils = {}
Private.DatabaseUtils = databaseUtils

---@param database table
---@param defaults table
function databaseUtils:CheckAndUpdate(database, defaults)
    for key, value in pairs(defaults) do
        if type(value) == "table" then
            if database[key] == nil then
                print("Setting default for missing key (table):", key)
                database[key] = {}
            end
            self:CheckAndUpdate(database[key], value)
        else
            if database[key] == nil then
                print("Setting default for missing key:", key, "=", tostring(value))
                database[key] = value
            end
        end
    end
end

function databaseUtils:LoadDefaultsForMissing()
    local addon = Private.Addon
    local defaults = addon.DefaultDatabase
    local database = addon.Database

    self:CheckAndUpdate(database, defaults)
end