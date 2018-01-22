#include "tile.h"

Tile::Tile(int value)
    : m_value(value)
{
}

void Tile::value(int newValue)
{
    m_value = newValue;
}
