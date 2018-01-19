#ifndef TILE_H
#define TILE_H

class Tile
{
public:
    Tile(int value);

    void value(int newValue);

    int value() const
    {
        return m_value;
    }

private:
    int m_value;
};

#endif // TILE_H
