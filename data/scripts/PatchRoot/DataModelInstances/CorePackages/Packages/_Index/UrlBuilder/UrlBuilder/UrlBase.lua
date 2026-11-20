-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local BaseUrl = game:GetService("ContentProvider").BaseUrl
local var1 = string.gsub(BaseUrl, ".*://", "")
local var2 = string.gsub(var1, "/.*", "")
local var3 = string.gsub(var2, "^www%.", "")

local module = {}

function module.new(arg1, arg2)
    assert(type(arg1) == "string", "UrlBase.new: `name` should be a string")
    arg2 = arg2 == nil and {} or arg2

    arg2 = (type(arg2) == "number" or type(arg2) == "string") and { version = arg2 } or arg2

    assert(type(arg2) == "table", "UrlBase.new: `params` should be a table")
    local proto = arg2.proto
    local version = arg2.version
    local path = arg2.path
    if proto == nil then
        proto = if arg2.secure == false then "http" else "https"
    end

    if #proto > 0 then
        proto ..= "://"
    end
    local var4 = proto .. arg1
    if #arg1 > 0 then
        var4 ..= "."
    end
    local var5 = var4 .. var3
    if version ~= nil and #tostring(version) > 0 then
        var5 ..= "/v" .. tostring(version)
    end
    if path ~= nil and #path > 0 then
        var5 ..= "/" .. path
    end
    return var5
end

local bool1 = string.sub(var3, -6) == "qq.com"

module.API = module.new("api")
module.APIS = module.new("apis")
module.APIS_RBXCDN = "https://apis.rbxcdn.com"
module.AUTH = module.new("auth")
module.CHAT = module.new("chat")
module.CREATE = module.new("create")
module.FRIENDS = module.new("friends", 1)
module.ASSETGAME = module.new("assetgame")
module.GAMES = module.new("games", 1)
module.NOTIFICATION = module.new("notification", 2)
module.NOTIFICATIONS = module.new("notifications", 2)
module.PRESENCE = module.new("presence", 1)
module.REALTIME = module.new("realtime")
module.WEB = module.new("web")
module.WWW = module.new("www")
module.ADS = module.new("ads", 1)
module.ADCONFIGURATION = module.new("adconfiguration", 2)
module.FOLLOWINGS = module.new("followings", 1)
module.PREMIUM = module.new("premiumfeatures", 1)
module.BLOG = "https://blog.roblox.com"
module.CORP = if bool1 then "https://roblox.qq.com" else "https://corp.roblox.com"
module.USERMODERATION = module.new("usermoderation")
module.ACCOUNTINFORMATION = module.new("accountinformation", 1)

module.ACCOUNTSETTINGS = module.new("accountsettings")
module.BADGES = module.new("badges", 1)
module.INVENTORY = module.new("inventory", 1)
module.CATALOG = module.new("catalog", 1)

module.AVATAR = module.new("avatar", 1)

module.MOBILENAV = "roblox://navigation"
module.APPSFLYER = "https://ro.blox.com"

return module
