-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")

local dependencies = require(ContactImporter.dependencies)
local Constants = require(ContactImporter.Common.Constants)

local getFIntContactImporterUploadContactsMax = require(ContactImporter.Flags.getFIntContactImporterUploadContactsMax)
local getFIntContactImporterUploadContactsMin = require(ContactImporter.Flags.getFIntContactImporterUploadContactsMin)

local DeviceContact = dependencies.RoduxContacts.Models.DeviceContact

return function(arg1)
    local contacts = {}
    local fIntContactImporterUploadContactsMax = getFIntContactImporterUploadContactsMax()
    local fIntContactImporterUploadContactsMin = getFIntContactImporterUploadContactsMin()

    for _, contact in pairs(arg1.contacts) do
        for _, value in pairs(contact.phonenumber) do
            if fIntContactImporterUploadContactsMax <= #contacts then
                break
            end

            local tbl2 = {
                idAssignedByFE = DeviceContact.generateId(contact),
                fields = 0
            }
            local tbl3 = {
                name = Constants.LAST_NAME,
                value = if contact.lastname == nil then "" else tostring(contact.lastname)
            }
            local tbl4 = {
                name = Constants.FIRST_NAME,
                value = if contact.firstname == nil then "" else tostring(contact.firstname)
            }
            tbl2.fields = {
                tbl3,
                tbl4,
                {
                    name = Constants.PHONE_NUMBER,
                    value = tostring(value):gsub("%s+", "")
                }
            }

            table.insert(contacts, tbl2)
        end
    end

    local contactsLen = #contacts

    if fIntContactImporterUploadContactsMin <= contactsLen then
        return {
            countryCode = arg1.countryCode,
            contacts = contacts,
            contactsCount = contactsLen,
            source = arg1.source
        }
    end

    if contactsLen < fIntContactImporterUploadContactsMin then
        return {
            countryCode = arg1.countryCode,
            contacts = {},
            contactsCount = contactsLen,
            source = arg1.source
        }
    end

    return {
        countryCode = arg1.countryCode,
        contacts = contacts,
        contactsCount = contactsLen,
        source = arg1.source
    }
end
