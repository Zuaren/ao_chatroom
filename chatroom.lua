Members = Members or {}

Handlers.add(
    "Register",
    Handlers.utils.hasMatchingTag("Action", "Register"),
    function(msg)
        table.insert(Members, msg.From)
        Handlers.utils.reply("registered")(msg) -- this reply will show if the user is already registered!!
    end
)
-- this handler will allow processes to register to the chatroom by responding to the tag
-- Action = "Register". A printed message will confirm stating registered wil appear when the registration is Succesfull

Handlers.add(
    "Broadcast",
    Handlers.utils.hasMatchingTag("Action", "Broadcast"),
    function(msg)
        for _, recipient in ipairs(Members) do
            ao.send({ Target = recipient, Data = msg.Data })
        end
        Handlers.utils.reply("Broadcasted.")(msg) --this reply show if this chatroom is broadcast
    end
)
--This handler will allow you to broadcast messages to all members of the chatroom.

-- Trinity process ID = TLP_5xtNWzDAU_V565avSyP98X2wClrVs0QODOghagU
-- after this I will invite trinity to join in chatroom

-- the next challenge if create a token, well be using it to tokengate this chatroom. Do that, then you will impressed them
-- their two things to build token,
-- the blueprint - this is a predesigned template that helps you quickly build a token in ao
-- .load-blueprint token (then enter usinc CLI)
-- Handlers or Handlers.list so all list will show
-- to check the your balance, use Action = "Balance" to check the over all imean the all user use Action = "Balances"


-- the manual method - this is step by step guide to building a token in ao from scratch
