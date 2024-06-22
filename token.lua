-- Step 1: Initializing the Token
local json = require('json')

if not Balances then Balances = { [ao.id] = 100000000000000 } end

if Name ~= 'My Coin' then Name = 'My Coin' end

if Ticker ~= 'COIN' then Ticker = 'COIN' end

if Denomination ~= 10 then Denomination = 10 end

if not Logo then Logo = 'optional arweave TXID of logo image' end

-- Now lets add our first Handler to handle incoming Messages.
-- add(name, pattern, handle)
--This code means that if someone Sends a message with the Tag, Action = "info",
--our token will Send back a message with all of the information defined above. Note the Target = msg.From,
-- this tells ao we are replying to the process that sent us this message.
Handlers.add('info', Handlers.utils.hasMatchingTag('Action', 'info'), function(msg)
    ao.send(
        { Target = msg.From, Tags = { Name = Name, Ticker = Ticker, Logo = Logo, Denomination = tostring(Denomination) } }
    )
end)

-- Step 2: Info and Balances Handlers

--Info & Token Balance Handlers
--Now we can add 2 Handlers which provide information about token Balances and Balance.

-- balance name of handlers, pattern
Handlers.add('Balance', Handlers.utils.hasMatchingTag('Action', 'Balance'), function(msg)
    -- initialize balance to bal that equal to 0
    local bal = '0';

    -- if not Target is provided, then return the Senders Balance
    if (msg.Tags.Target and Balances[msg.Tags.Target]) then
        bal = tostring(Balances[msg.Tags.Target])
    elseif Balances[msg.From] then
        bal = tostring(Balances[msg.From])
    end
    ao.send({
        Target = msg.From,
        Tags = {
            Target = msg.From,
            Balance = bal,
            Ticker = Ticker,
            Data = json.encode(tonumber(bal))
        }
    })
end)

-- this first handlers above Handlers.add('Balance' handles process or person request their own balance or the balance of a target then may mga replies message
-- that containing the info

Handlers.add('Balances', Handlers.utils.hasMatchingTag('Action', 'Balances'), function(msg)
    ao.send({ Target = msg.From, Data = json.encode(Balances) })
end)

-- Step 3: Transfer Handlers
