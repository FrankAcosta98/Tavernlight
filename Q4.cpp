//Q1

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
Player* player = g_game.getPlayerByName(recipient);
if (!player) {
player = new Player(nullptr);
if (!IOLoginData::loadPlayerByName(player, recipient)) {
return;
}
}

Item* item = Item::CreateItem(itemId);
if (!item) {
return;
}

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

if (player->isOffline()) {
IOLoginData::savePlayer(player);
}
}

//Fixed

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false;

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Deallocate memory if loading fails
            return;
        }
        playerCreated = true; // Set flag indicating that player object was created
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player; // Deallocate memory if item creation fails and player was created
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (playerCreated) {
        delete player; // Deallocate memory if player object was created
    }
}
