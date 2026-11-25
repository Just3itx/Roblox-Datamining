-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)

local tryLoadRbxthumbAsync = require(Songbird.Common.tryLoadRbxthumbAsync)

local useAsync = ReactUtils.useAsync
local useMemo = React.useMemo

local tbl1 = {
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_blue.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_green.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_magenta.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_orange.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_pink.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_purple.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_turquoise.png",
    "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_yellow.png"
}

local tbl2 = {
    Icon = Vector2.new(420, 420),
    Masthead = Vector2.new(1440, 456)
}

local function getFallbackMusicThumbnail(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        if typeof(arg1) == "string" then
            arg1 = tonumber((arg1:match("(%d+)$")))
        end

        if arg1 then
            return tbl1[arg1 % #tbl1 + 1]
        end
    end

    return "rbxasset://textures/ui/LuaApp/graphic/album_art_fallback_gray.png"
end

local function useSongAlbumArt(str1: string, str2: string?)
    local str3 = str2 or "Icon"

    local var1 = useMemo(function()
        return getFallbackMusicThumbnail(str1)
    end, { str1 })

    local var2 = useAsync(function()
        if str1 then
            local var2 = tbl2[str3]

            local str4 = `rbxthumb://type=Asset&id={str1}&w={var2.X}&h={var2.Y}`
            if pcall(tryLoadRbxthumbAsync, str4) then
                return str4
            end
        end
        return nil
    end, { str3, str1 })

    local value = useMemo(function()
        return if var2.status == "ok" and var2.value then var2.value else var1
    end, { var2, var1 })

    return {
        status = var2.status,
        value = value
    }
end

return useSongAlbumArt
