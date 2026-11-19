-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
local str1 = game:GetService("ContentProvider").BaseUrl:lower()
local var1 = string.gsub(str1, "/m.", "/www.")
local var2 = string.gsub(var1, "/www.", "/thumbnails.")
return {
    Headshot = "rbxthumb://type=AvatarHeadShot&id=%d&w=%d&h=%d",
    Bust = string.gsub(var2, "http:", "https:") .. "v1/users/avatar-bust?userIds=%d&size=%dx%d&format=Png&isCircular=false",
    Thumbnail = "rbxthumb://type=Avatar&id=%d&w=%d&h=%d"
}
