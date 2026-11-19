-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local tbl1 = {
    Value = false,
    ChangedEvent = Instance.new("BindableEvent")
}

local function getAnimateScript(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
    if not arg1 then
        return nil
    end

    local animate = arg1:FindFirstChild("Animate")

    if animate and animate:IsA("LocalScript") then
        return animate
    end

    if animate and animate:IsA("Script") and animate.RunContext == Enum.RunContext.Client then
        return animate
    end

    return nil
end

local function getPlayEmoteBindable(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
    local animateScript = getAnimateScript(arg1)

    if not animateScript then
        return nil
    end

    local playEmote = animateScript:FindFirstChild("PlayEmote")
    return if playEmote and playEmote:IsA("BindableFunction") then playEmote else nil
end

local function getCanPlayEmotes(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return getPlayEmoteBindable(arg1) ~= nil
end

local connection = nil
local connection2 = nil
local connection3 = nil

local function disconnectListeners() -- Luacid: Inlined by compiler; 4 call sites recovered
    if connection then
        connection:Disconnect()
        connection = nil
    end

    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end

    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end
end

local var1 = nil

local function checkUpdate(character) -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = getCanPlayEmotes(character)

    if tbl1.Value ~= bool1 then
        tbl1.Value = bool1
        tbl1.ChangedEvent:Fire(bool1)
    end

    var1(bool1, character)
end

local function connectAnimateAddedListener(arg1) -- Luacid: unused: defined but never referenced
    if getAnimateScript(arg1) then
        local animate

        if arg1 then
            animate = arg1:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, arg1)

        return
    end

    connection = arg1.ChildAdded:Connect(function(child: Instance)
        if not child:IsA("LocalScript") and (not child:IsA("Script") or child.RunContext ~= Enum.RunContext.Client)
            or child.Name ~= "Animate"
        then
            return
        end

        local var2 = arg1
        local animate

        if var2 then
            animate = var2:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, var2)
    end)
end

local function connectPlayEmoteAddedListener(arg1, arg2) -- Luacid: unused: defined but never referenced
    if getPlayEmoteBindable(arg1) then
        local animate

        if arg1 then
            animate = arg1:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, arg1)

        return
    end

    connection2 = arg2.ChildAdded:Connect(function(child: Instance)
        if not child:IsA("BindableFunction") or child.Name ~= "PlayEmote" then
            return
        end

        local var2 = arg1
        local animate

        if var2 then
            animate = var2:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, var2)
    end)
end

local function connectPlayEmoteRemovedListener(arg1) -- Luacid: unused: defined but never referenced
    local playEmoteBindable = getPlayEmoteBindable(arg1)

    if not playEmoteBindable then
        local animate

        if arg1 then
            animate = arg1:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, arg1)

        return
    end

    connection3 = playEmoteBindable.AncestryChanged:Connect(function(_: Instance, parent: Instance)
        if parent and playEmoteBindable:IsDescendantOf(arg1) then
            return
        end

        local var2 = arg1
        local animate

        if var2 then
            animate = var2:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, var2)
    end)
end

var1 = function(arg1, arg2)
    disconnectListeners()

    if not arg2 then
        return
    end

    if arg1 then
        local playEmoteBindable = getPlayEmoteBindable(arg2)

        if not playEmoteBindable then
            local animate

            if arg2 then
                animate = arg2:FindFirstChild("Animate")
                if not (animate and animate:IsA("LocalScript"))
                    and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
                then
                    animate = nil
                end
            else
                animate = nil
            end

            local playEmote

            if animate then
                playEmote = animate:FindFirstChild("PlayEmote")
                if not (playEmote and playEmote:IsA("BindableFunction")) then
                    playEmote = nil
                end
            else
                playEmote = nil
            end

            local bool1 = playEmote ~= nil

            if tbl1.Value ~= bool1 then
                tbl1.Value = bool1
                tbl1.ChangedEvent:Fire(bool1)
            end

            var1(bool1, arg2)

            return
        end

        connection3 = playEmoteBindable.AncestryChanged:Connect(function(_: Instance, parent: Instance)
            if parent and playEmoteBindable:IsDescendantOf(arg2) then
                return
            end

            local var2 = arg2
            local animate

            if var2 then
                animate = var2:FindFirstChild("Animate")
                if not (animate and animate:IsA("LocalScript"))
                    and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
                then
                    animate = nil
                end
            else
                animate = nil
            end

            local playEmote

            if animate then
                playEmote = animate:FindFirstChild("PlayEmote")
                if not (playEmote and playEmote:IsA("BindableFunction")) then
                    playEmote = nil
                end
            else
                playEmote = nil
            end

            local bool1 = playEmote ~= nil

            if tbl1.Value ~= bool1 then
                tbl1.Value = bool1
                tbl1.ChangedEvent:Fire(bool1)
            end

            var1(bool1, var2)
        end)

        return
    end

    local animateScript = getAnimateScript(arg2)

    if animateScript then
        if getPlayEmoteBindable(arg2) then
            local animate

            if arg2 then
                animate = arg2:FindFirstChild("Animate")
                if not (animate and animate:IsA("LocalScript"))
                    and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
                then
                    animate = nil
                end
            else
                animate = nil
            end

            local playEmote

            if animate then
                playEmote = animate:FindFirstChild("PlayEmote")
                if not (playEmote and playEmote:IsA("BindableFunction")) then
                    playEmote = nil
                end
            else
                playEmote = nil
            end

            local bool1 = playEmote ~= nil

            if tbl1.Value ~= bool1 then
                tbl1.Value = bool1
                tbl1.ChangedEvent:Fire(bool1)
            end

            var1(bool1, arg2)

            return
        end

        connection2 = animateScript.ChildAdded:Connect(function(child: Instance)
            if not child:IsA("BindableFunction") or child.Name ~= "PlayEmote" then
                return
            end

            local var2 = arg2
            local animate

            if var2 then
                animate = var2:FindFirstChild("Animate")
                if not (animate and animate:IsA("LocalScript"))
                    and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
                then
                    animate = nil
                end
            else
                animate = nil
            end

            local playEmote

            if animate then
                playEmote = animate:FindFirstChild("PlayEmote")
                if not (playEmote and playEmote:IsA("BindableFunction")) then
                    playEmote = nil
                end
            else
                playEmote = nil
            end

            local bool1 = playEmote ~= nil

            if tbl1.Value ~= bool1 then
                tbl1.Value = bool1
                tbl1.ChangedEvent:Fire(bool1)
            end

            var1(bool1, var2)
        end)
    elseif getAnimateScript(arg2) then
        local animate

        if arg2 then
            animate = arg2:FindFirstChild("Animate")
            if not (animate and animate:IsA("LocalScript"))
                and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
            then
                animate = nil
            end
        else
            animate = nil
        end

        local playEmote

        if animate then
            playEmote = animate:FindFirstChild("PlayEmote")
            if not (playEmote and playEmote:IsA("BindableFunction")) then
                playEmote = nil
            end
        else
            playEmote = nil
        end

        local bool1 = playEmote ~= nil

        if tbl1.Value ~= bool1 then
            tbl1.Value = bool1
            tbl1.ChangedEvent:Fire(bool1)
        end

        var1(bool1, arg2)
    else
        connection = arg2.ChildAdded:Connect(function(child: Instance)
            if not child:IsA("LocalScript") and (not child:IsA("Script") or child.RunContext ~= Enum.RunContext.Client)
                or child.Name ~= "Animate"
            then
                return
            end

            local var2 = arg2
            local animate

            if var2 then
                animate = var2:FindFirstChild("Animate")
                if not (animate and animate:IsA("LocalScript"))
                    and (not (animate and animate:IsA("Script")) or animate.RunContext ~= Enum.RunContext.Client)
                then
                    animate = nil
                end
            else
                animate = nil
            end

            local playEmote

            if animate then
                playEmote = animate:FindFirstChild("PlayEmote")
                if not (playEmote and playEmote:IsA("BindableFunction")) then
                    playEmote = nil
                end
            else
                playEmote = nil
            end

            local bool1 = playEmote ~= nil

            if tbl1.Value ~= bool1 then
                tbl1.Value = bool1
                tbl1.ChangedEvent:Fire(bool1)
            end

            var1(bool1, var2)
        end)
    end
end

local function onCharacterChanged(character) -- Luacid: Inlined by compiler; 2 call sites recovered
    disconnectListeners()
    checkUpdate(character)
end

LocalPlayer:GetPropertyChangedSignal("Character"):Connect(function()
    onCharacterChanged(LocalPlayer.Character)
end)
onCharacterChanged(LocalPlayer.Character)

return tbl1
