-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParent = script.Parent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)
local Promise = require(scriptParentParent.Promise)

local _CredentialsProtocolTypes = require(script.Parent.CredentialsProtocolTypes)
local Constants = require(script.Parent.Constants)
local normalizeUnifiedGetCredentialsResponse = require(script.Parent.normalizeUnifiedGetCredentialsResponse)

local FFlagLuaAppNormalizeUnifiedPasskeyResponse = require(script.Parent.Flags.FFlagLuaAppNormalizeUnifiedPasskeyResponse)

local FFlagCacheCredentialsProtocolIsAvailable = require(script.Parent.Flags.FFlagCacheCredentialsProtocolIsAvailable)

local CredentialsTypes = Constants.CredentialsTypes

local function isNativeIsAvailableReply(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.isAvailable ~= nil
        or arg1.FIDO2 ~= nil
        or arg1.password ~= nil
        or arg1.iosKeychainPassword ~= nil
        or arg1.keystore ~= nil
end

local parameters = t.strictInterface({
    keyType = t.optional(t.string),
    publicKey = t.interface({
        challenge = t.string,
        timeout = t.optional(t.number),
        rpId = t.optional(t.string),
        allowCredentials = t.optional(t.table),
        userVerification = t.optional(t.string),
        attestation = t.optional(t.string),
        extensions = t.optional(t.table)
    }),
    deviceBoundOnly = t.optional(t.boolean)
})

local tbl1 = {
    [CredentialsTypes.FIDO2] = t.strictInterface({ credentialType = t.string, parameters = parameters }),
    [CredentialsTypes.all] = t.strictInterface(
        {
            FIDO2 = t.optional(parameters),
            password = t.optional(t.strictInterface({ username = t.optional(t.string) }))
        }
    ),
    [CredentialsTypes.iosKeychainPassword] = t.strictInterface({ credentialType = t.string, parameters = t.interface({ server = t.optional(t.string) }) }),
    [CredentialsTypes.keystore] = t.strictInterface(
        {
            credentialType = t.string,
            parameters = t.interface({ server = t.optional(t.string), key = t.optional(t.string) })
        }
    )
}

local var2 = t.strictInterface({
    id = t.optional(t.string),
    rawId = t.optional(t.string),
    type = t.optional(t.string),
    response = t.interface(
        {
            authenticatorData = t.string,
            clientDataJSON = t.string,
            signature = t.string,
            userHandle = t.optional(t.string)
        }
    ),
    errorCode = t.optional(t.string),
    errorMsg = t.optional(t.string)
})

local var3 = t.strictInterface({
    credentialType = t.string,
    response = t.union(
        var2,
        t.strictInterface({
            username = t.optional(t.string),
            password = t.optional(t.string),
            errorCode = t.optional(t.string),
            errorMsg = t.optional(t.string)
        })
    )
})

local tbl2 = {
    [CredentialsTypes.FIDO2] = var2
}
local all = CredentialsTypes.all

if FFlagLuaAppNormalizeUnifiedPasskeyResponse then
    var3 = t.union(var3, var2)
end

tbl2[all] = var3

tbl2[CredentialsTypes.iosKeychainPassword] = t.array(
    t.strictInterface({
        experimentGroup = t.optional(t.string),
        username = t.optional(t.string),
        userId = t.optional(t.string),
        password = t.optional(t.string),
        errorCode = t.optional(t.string),
        errorMsg = t.optional(t.string)
    })
)
tbl2[CredentialsTypes.keystore] = t.array(
    t.strictInterface({
        experimentGroup = t.optional(t.string),
        username = t.optional(t.string),
        userId = t.optional(t.string),
        password = t.optional(t.string),
        errorCode = t.optional(t.string),
        errorMsg = t.optional(t.string)
    })
)

local tbl3 = {
    [CredentialsTypes.FIDO2] = t.strictInterface({
        credentialType = t.string,
        parameters = t.interface({
            keyType = t.optional(t.string),
            isSilentPasskeyUpgrade = t.optional(t.boolean),
            publicKey = t.interface({
                rp = t.interface({ name = t.string, id = t.string }),
                user = t.interface({ name = t.string, displayName = t.string, id = t.string }),
                challenge = t.string,
                pubKeyCredParams = t.optional(t.table),
                timeout = t.optional(t.number),
                excludeCredentials = t.optional(t.table),
                authenticationSelection = t.optional(t.table),
                attestation = t.optional(t.string),
                extensions = t.optional(t.table)
            })
        })
    }),
    [CredentialsTypes.password] = t.strictInterface(
        {
            credentialType = t.string,
            parameters = t.strictInterface({ username = t.string, password = t.string })
        }
    ),
    [CredentialsTypes.iosKeychainPassword] = t.strictInterface({
        credentialType = t.string,
        parameters = t.strictInterface({
            server = t.string,
            username = t.string,
            userId = t.string,
            password = t.string,
            experimentGroup = t.optional(t.string)
        })
    }),
    [CredentialsTypes.keystore] = t.strictInterface({
        credentialType = t.string,
        parameters = t.strictInterface({
            server = t.string,
            key = t.optional(t.string),
            username = t.string,
            userId = t.string,
            password = t.string,
            experimentGroup = t.optional(t.string)
        })
    })
}

local tbl4 = {
    [CredentialsTypes.FIDO2] = t.strictInterface({
        id = t.optional(t.string),
        rawId = t.optional(t.string),
        type = t.optional(t.string),
        response = t.interface({ clientDataJSON = t.string, attestationObject = t.string }),
        authenticatorAttachment = t.optional(t.string),
        clientExtensionResults = t.optional(t.table),
        errorCode = t.optional(t.string),
        errorMsg = t.optional(t.string)
    }),
    [CredentialsTypes.password] = t.strictInterface({ errorCode = t.optional(t.string), errorMsg = t.optional(t.string) }),
    [CredentialsTypes.iosKeychainPassword] = t.strictInterface({ errorCode = t.optional(t.string), errorMsg = t.optional(t.string) }),
    [CredentialsTypes.keystore] = t.strictInterface({ errorCode = t.optional(t.string), errorMsg = t.optional(t.string) })
}

local module = {
    CredentialsTypes = CredentialsTypes,
    GET_CREDENTIALS_REQUEST_DESCRIPTOR = {
        [CredentialsTypes.FIDO2] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsRequest"),
            validateParams = tbl1[CredentialsTypes.FIDO2]
        },
        [CredentialsTypes.all] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsRequest"),
            validateParams = tbl1[CredentialsTypes.all]
        },
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsRequest"),
            validateParams = tbl1[CredentialsTypes.iosKeychainPassword]
        },
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsRequest"),
            validateParams = tbl1[CredentialsTypes.keystore]
        }
    },
    GET_CREDENTIALS_RESPONSE_DESCRIPTOR = {
        [CredentialsTypes.FIDO2] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsResponse"),
            validateParams = tbl2[CredentialsTypes.FIDO2]
        },
        [CredentialsTypes.all] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsResponse"),
            validateParams = tbl2[CredentialsTypes.all]
        },
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsResponse"),
            validateParams = tbl2[CredentialsTypes.iosKeychainPassword]
        },
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "getCredentialsResponse"),
            validateParams = tbl2[CredentialsTypes.keystore]
        }
    },
    DELETE_IOS_KEYCHAIN_CREDENTIALS_REQUEST_DESCRIPTOR = {
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "deleteIosKeychainCredentialsRequest"),
            validateParams = t.strictInterface({ credentialType = t.string, parameters = t.strictInterface({ server = t.string }) })
        }
    },
    DELETE_KEYSTORE_CREDENTIALS_REQUEST_DESCRIPTOR = {
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "deleteKeystoreCredentialsRequest"),
            validateParams = t.strictInterface(
                {
                    credentialType = t.string,
                    parameters = t.strictInterface({ server = t.string, key = t.optional(t.string) })
                }
            )
        }
    },
    DELETE_IOS_KEYCHAIN_CREDENTIALS_RESPONSE_DESCRIPTOR = {
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "deleteIosKeychainCredentialsResponse"),
            validateParams = t.strictInterface({
                credentialType = t.string,
                response = t.array(t.strictInterface({ errorCode = t.optional(t.string), errorMsg = t.optional(t.string) }))
            })
        }
    },
    DELETE_KEYSTORE_CREDENTIALS_RESPONSE_DESCRIPTOR = {
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "deleteKeystoreCredentialsResponse"),
            validateParams = t.strictInterface({
                credentialType = t.string,
                response = t.array(t.strictInterface({ errorCode = t.optional(t.string), errorMsg = t.optional(t.string) }))
            })
        }
    },
    REGISTER_CREDENTIALS_REQUEST_DESCRIPTOR = {
        [CredentialsTypes.FIDO2] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsRequest"),
            validateParams = tbl3[CredentialsTypes.FIDO2]
        },
        [CredentialsTypes.password] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsRequest"),
            validateParams = tbl3[CredentialsTypes.password]
        },
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsRequest"),
            validateParams = tbl3[CredentialsTypes.iosKeychainPassword]
        },
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsRequest"),
            validateParams = tbl3[CredentialsTypes.keystore]
        }
    },
    REGISTER_CREDENTIALS_RESPONSE_DESCRIPTOR = {
        [CredentialsTypes.FIDO2] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsResponse"),
            validateParams = tbl4[CredentialsTypes.FIDO2]
        },
        [CredentialsTypes.password] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsResponse"),
            validateParams = tbl4[CredentialsTypes.password]
        },
        [CredentialsTypes.iosKeychainPassword] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsResponse"),
            validateParams = tbl4[CredentialsTypes.iosKeychainPassword]
        },
        [CredentialsTypes.keystore] = {
            mid = MessageBus.getMessageId("Credentials", "registerCredentialsResponse"),
            validateParams = tbl4[CredentialsTypes.keystore]
        }
    },
    IS_AVAILABLE_REQUEST_DESCRIPTOR = {
        mid = MessageBus.getMessageId("Credentials", "isAvailableRequest"),
        validateParams = t.strictInterface({ credentialType = t.optional(t.valueOf(CredentialsTypes)) })
    },
    IS_AVAILABLE_RESPONSE_DESCRIPTOR = {
        mid = MessageBus.getMessageId("Credentials", "isAvailableResponse"),
        validateParams = t.strictInterface({
            isAvailable = t.optional(t.boolean),
            supportsDeviceBoundOnly = t.optional(t.boolean),
            FIDO2 = t.optional(
                t.strictInterface({
                    isAvailable = t.boolean,
                    supportsDeviceBoundOnly = t.boolean,
                    supportsSilentPasskeyUpgrade = t.optional(t.boolean),
                    supportsPasskeyCreationOnDevice = t.optional(t.boolean)
                })
            ),
            password = t.optional(t.strictInterface({ isAvailable = t.boolean })),
            iosKeychainPassword = t.optional(t.strictInterface({ isAvailable = t.boolean })),
            keystore = t.optional(t.strictInterface({ isAvailable = t.boolean }))
        })
    }
}

module.__index = module

function module.new()
    return (setmetatable({
        subscriber = MessageBus.Subscriber.new(),
        getCredentialsRequestInFlight = false,
        registerCredentialsRequestInFlight = false,
        deleteIosKeychainCredentialsRequestInFlight = false,
        deleteKeystoreCredentialsRequestInFlight = false
    }, module))
end

function module:getCredentials(credentialType: string, input: string, num1: number)
    if self.getCredentialsRequestInFlight then
        return Promise.reject()
    end

    local var4 = Promise.race({
        Promise.new(function(callback, _)
            self.subscriber:subscribe(self.GET_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType], function(input2)
                self.subscriber:unsubscribe(self.GET_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
                self.getCredentialsRequestInFlight = false
                if FFlagLuaAppNormalizeUnifiedPasskeyResponse and credentialType == CredentialsTypes.all then
                    input2 = normalizeUnifiedGetCredentialsResponse(input2)
                end
                local str1 = HttpService:JSONEncode(input2)
                callback(str1)
            end)
        end),
        Promise.delay(num1):andThen(function()
            self.subscriber:unsubscribe(self.GET_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
            self.getCredentialsRequestInFlight = false
        end)
    })

    self.getCredentialsRequestInFlight = true

    if credentialType == CredentialsTypes.all then
        MessageBus.publish(self.GET_CREDENTIALS_REQUEST_DESCRIPTOR[credentialType], HttpService:JSONDecode(input))
    else
        MessageBus.publish(
            self.GET_CREDENTIALS_REQUEST_DESCRIPTOR[credentialType],
            {
                credentialType = credentialType,
                parameters = HttpService:JSONDecode(input)
            }
        )
    end
    return var4
end

function module:registerCredentials(credentialType: string, input: string, num1: number)
    if self.registerCredentialsRequestInFlight then
        return Promise.reject()
    end

    local var4 = Promise.race({
        Promise.new(function(callback, _)
            self.subscriber:subscribe(self.REGISTER_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType], function(input2)
                self.subscriber:unsubscribe(self.REGISTER_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
                self.registerCredentialsRequestInFlight = false
                local str1 = HttpService:JSONEncode(input2)
                callback(str1)
            end)
        end),
        Promise.delay(num1):andThen(function()
            self.subscriber:unsubscribe(self.REGISTER_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
            self.registerCredentialsRequestInFlight = false
        end)
    })

    self.registerCredentialsRequestInFlight = true
    MessageBus.publish(
        self.REGISTER_CREDENTIALS_REQUEST_DESCRIPTOR[credentialType],
        {
            credentialType = credentialType,
            parameters = HttpService:JSONDecode(input)
        }
    )
    return var4
end

function module:deleteAllCredentialsFromiOSKeychain(credentialType: string, input: string, num1: number)
    if self.deleteIosKeychainCredentialsRequestInFlight then
        return Promise.reject()
    end

    local var4 = Promise.race({
        Promise.new(function(callback, _)
            self.subscriber:subscribe(self.DELETE_IOS_KEYCHAIN_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType], function(input2)
                self.subscriber:unsubscribe(self.DELETE_IOS_KEYCHAIN_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
                self.deleteIosKeychainCredentialsRequestInFlight = false
                local str1 = HttpService:JSONEncode(input2)
                callback(str1)
            end)
        end),
        Promise.delay(num1):andThen(function()
            self.subscriber:unsubscribe(self.DELETE_IOS_KEYCHAIN_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
            self.deleteIosKeychainCredentialsRequestInFlight = false
        end)
    })

    self.deleteIosKeychainCredentialsRequestInFlight = true

    MessageBus.publish(
        self.DELETE_IOS_KEYCHAIN_CREDENTIALS_REQUEST_DESCRIPTOR[credentialType],
        {
            credentialType = credentialType,
            parameters = HttpService:JSONDecode(input)
        }
    )
    return var4
end

function module:deleteAllCredentialsFromKeystore(credentialType: string, input: string, num1: number)
    if self.deleteKeystoreCredentialsRequestInFlight then
        return Promise.reject()
    end

    local var4 = Promise.race({
        Promise.new(function(callback, _)
            self.subscriber:subscribe(self.DELETE_KEYSTORE_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType], function(input2)
                self.subscriber:unsubscribe(self.DELETE_KEYSTORE_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
                self.deleteKeystoreCredentialsRequestInFlight = false
                local str1 = HttpService:JSONEncode(input2)
                callback(str1)
            end)
        end),
        Promise.delay(num1):andThen(function()
            self.subscriber:unsubscribe(self.DELETE_KEYSTORE_CREDENTIALS_RESPONSE_DESCRIPTOR[credentialType])
            self.deleteKeystoreCredentialsRequestInFlight = false
        end)
    })

    self.deleteKeystoreCredentialsRequestInFlight = true

    MessageBus.publish(
        self.DELETE_KEYSTORE_CREDENTIALS_REQUEST_DESCRIPTOR[credentialType],
        {
            credentialType = credentialType,
            parameters = HttpService:JSONDecode(input)
        }
    )
    return var4
end

function module.sendIsAvailableRequest(tbl5, credentialType: string, num1: number)
    local var4 = Promise.race({
        Promise.new(function(callback, _)
            tbl5.subscriber:subscribe(tbl5.IS_AVAILABLE_RESPONSE_DESCRIPTOR, function(arg1)
                tbl5.subscriber:unsubscribe(tbl5.IS_AVAILABLE_RESPONSE_DESCRIPTOR)
                callback(arg1)
            end)
        end),
        Promise.delay(num1):andThen(function()
            tbl5.subscriber:unsubscribe(tbl5.IS_AVAILABLE_RESPONSE_DESCRIPTOR)

            return Promise.resolve({ isAvailable = nil, supportsDeviceBoundOnly = nil })
        end)
    })

    MessageBus.publish(tbl5.IS_AVAILABLE_REQUEST_DESCRIPTOR, { credentialType = credentialType })

    return var4
end

function module.isAvailable(tbl5, str1: string, num1: number)
    if not FFlagCacheCredentialsProtocolIsAvailable then
        return tbl5:sendIsAvailableRequest(str1, num1)
    end

    local isAvailableCache = tbl5.isAvailableCache
    if isAvailableCache ~= nil and os.clock() - isAvailableCache.clock < 30 then
        return Promise.resolve(isAvailableCache.result)
    end

    if tbl5.isAvailableRequest ~= nil then
        return tbl5.isAvailableRequest
    end

    local isAvailableRequest = tbl5:sendIsAvailableRequest(str1, num1)
    tbl5.isAvailableRequest = isAvailableRequest

    return isAvailableRequest:andThen(function(arg1)
        tbl5.isAvailableRequest = nil

        if isNativeIsAvailableReply(arg1) then
            tbl5.isAvailableCache = {
                result = arg1,
                clock = os.clock()
            }
        end

        return arg1
    end):catch(function(arg1)
        tbl5.isAvailableRequest = nil
        return Promise.reject(arg1)
    end)
end

module.default = module.new()

return module
