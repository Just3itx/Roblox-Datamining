-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local _CoreGui = game:GetService("CoreGui")

local UserProfileStore = require(CorePackages.Workspace.Packages.UserProfiles).Stores.UserProfileStore

local bool1 = game:DefineFastFlag("FixCharacterNameHandlerNilProfileCrash", false)

local tbl1 = ({})

local function setName(humanoid: Humanoid, arg1, tbl2)
    local inExperienceCombinedName = tbl2.names.inExperienceCombinedName
    local displayName = tbl2.names.displayName
    if tbl2.names.displayName ~= humanoid.DisplayName then
        return
    end

    humanoid.InternalDisplayName = inExperienceCombinedName
    tbl1[arg1].HumanoidDisplayNameChanged = humanoid:GetPropertyChangedSignal("DisplayName"):Connect(function()
        if displayName ~= humanoid.DisplayName then
            humanoid.InternalDisplayName = ""
        end
    end)
end

local function checkHumanoid(arg1, character, tbl2)
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        setName(humanoid, arg1, tbl2)
    end
    tbl1[arg1].CharacterHumanoidAdded = character.ChildAdded:Connect(function(child: Instance)
        if child:IsA("Humanoid") then
            setName(child, arg1, tbl2)
        end
    end)
end

local function setNameOnCharacterAdded(arg1, tbl2)
    tbl1[arg1] = {}
    if arg1.Character then
        checkHumanoid(arg1, arg1.Character, tbl2)
    end

    tbl1[arg1].CharacterAdded = arg1.CharacterAdded:Connect(function(character: Model)
        checkHumanoid(arg1, character, tbl2)
    end)
    tbl1[arg1].CharacterRemoving = arg1.CharacterRemoving:Connect(function()
        local characterHumanoidAdded = tbl1[arg1].CharacterHumanoidAdded
        local humanoidDisplayNameChanged = tbl1[arg1].HumanoidDisplayNameChanged
        if characterHumanoidAdded then
            tbl1[arg1].CharacterHumanoidAdded:Disconnect()
        end
        if humanoidDisplayNameChanged then
            tbl1[arg1].HumanoidDisplayNameChanged:Disconnect()
        end
    end)
end

local function setCurrentPlayersNames()
    local players = Players:GetPlayers()
    local tbl2 = {}
    local tbl3 = {}
    for _, player in pairs(players) do
        table.insert(tbl2, tostring(player.UserId))
        local userId = player.UserId
        tbl3[tostring(userId)] = player
    end
    UserProfileStore.get().fetchNamesByUserIds(tbl2, function(arg1)
        local status = arg1.status
        local data = arg1.data
        if status ~= "success" then
            return
        end

        for _, value in data do
            local var1 = tbl3[value.userId]
            if bool1 and (not var1 or value.names == nil) then
                continue
            end

            setNameOnCharacterAdded(var1, {
                names = {
                    inExperienceCombinedName = value.names.getInExperienceCombinedName(false),
                    displayName = value.names.getDisplayName(false)
                }
            })
        end
    end)
end

setCurrentPlayersNames()

Players.PlayerAdded:Connect(function(player: Player) -- name: onPlayerAdded
    local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
    local tbl2 = { tostring(player.UserId) }

    fetchNamesByUserIds(tbl2, function(arg1)
        local status = arg1.status
        local data = arg1.data
        local bool2 = not bool1 or #data > 0 and data[1].names ~= nil

        if status ~= "success" or not bool2 then
            return
        end

        local var1 = data[1]
        setNameOnCharacterAdded(player, {
            names = {
                inExperienceCombinedName = var1.names.getInExperienceCombinedName(false),
                displayName = var1.names.getDisplayName(false)
            }
        })
    end)
end)

Players.PlayerRemoving:Connect(function(player: Player) -- name: onPlayerRemoving
    local var1 = tbl1[player]
    if tbl1[player] then
        for _, value in pairs(var1) do
            value:Disconnect()
        end
        tbl1[player] = nil
    end
    UserProfileStore.get().invalidateCachedNamesForUserIds({ tostring(player.UserId) })
end)
