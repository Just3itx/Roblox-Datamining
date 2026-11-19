-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local Immutable = require(script.Parent.Parent.Immutable)

return function(arg1, arg2)
    return Rodux.createReducer(
        {
            clientSearchTerm = "",
            clientTypeFilters = {},
            serverSearchTerm = "",
            serverTypeFilters = {}
        },
        {
            ClientLogAppendMessage = function(arg3, arg4)
                return Immutable.JoinDictionaries(arg3, { clientData = Immutable.Append(arg3.clientData, arg4.newMessage) })
            end,
            ServerLogAppendMessage = function(arg3, arg4)
                return Immutable.JoinDictionaries(arg3, { serverData = Immutable.Append(arg3.serverData, arg4.newMessage) })
            end,
            ClientLogAppendFilteredMessage = function(arg3, arg4)
                local tbl1 = {
                    clientData = Immutable.Append(arg3.clientData, arg4.newMessage),
                    clientDataFiltered = Immutable.Append(arg3.clientDataFiltered, arg4.newMessage)
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end,
            ServerLogAppendFilteredMessage = function(arg3, arg4)
                local tbl1 = {
                    serverData = Immutable.Append(arg3.serverData, arg4.newMessage),
                    serverDataFiltered = Immutable.Append(arg3.serverDataFiltered, arg4.newMessage)
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end,
            ClientLogSetData = function(arg3, arg4)
                local tbl1 = {
                    clientData = arg4.newData,
                    clientDataFiltered = arg4.newDataFiltered
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end,
            ServerLogSetData = function(arg3, arg4)
                local tbl1 = {
                    serverData = arg4.newData,
                    serverDataFiltered = arg4.newDataFiltered
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end,
            ClientLogUpdateSearchFilter = function(arg3, arg4)
                local tbl1 = {
                    clientSearchTerm = arg4.searchTerm,
                    clientTypeFilters = Immutable.JoinDictionaries(arg3.clientTypeFilters, arg4.filterTypes)
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end,
            ServerLogUpdateSearchFilter = function(arg3, arg4)
                local tbl1 = {
                    serverSearchTerm = arg4.searchTerm,
                    serverTypeFilters = Immutable.JoinDictionaries(arg3.serverTypeFilters, arg4.filterTypes)
                }
                return Immutable.JoinDictionaries(arg3, tbl1)
            end
        }
    )(
        arg1,
        arg2
    )
end
