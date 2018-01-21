#include <algorithm>
#include <QTime>

#include "playboardmodel.h"

PlayBoardModel::PlayBoardModel(QObject *parent)
    : QAbstractListModel(parent), m_boardSize(0)
{
}

PlayBoardModel::PlayBoardModel(int boardSize)
    : m_boardSize(boardSize)
{
    shufflePlayBoard();
}

bool PlayBoardModel::isVictory()
{
    for(int i = 0; i < size(); i++)
    {
        if(i != m_tiles.at(i).value()) {
            return false;
        }
    }
    return true;
}

void PlayBoardModel::shufflePlayBoard()
{
    clearModel();
    QVector<int> randomValues = generateRandomVector(size());
    for(int i(0); i < size(); ++i) {
        appendTile(Tile(randomValues[i]));
    }

    if(!isSolvable()) {
        beginMoveRows(QModelIndex(), size() - 1, size() - 1, QModelIndex(), size() - 2);
        m_tiles.swap(size() - 1, size() - 2);
        endMoveRows();
    }
}

bool PlayBoardModel::playBoardMakeMove(int index)
{
    int right = (index + 1) % boardSize() != 0 ? (index + 1) : -1;
    int left =  (index - 1) % boardSize() != boardSize() - 1 ? (index - 1) : -1;
    int down = (index + boardSize());
    int up =  (index - boardSize());

    int freeTilePosition = 0;

    for(int i = 0; i < size(); i++) {
        if (m_tiles.at(i).value() == size() - 1) {
            freeTilePosition = i;
            break;
        }
    }

    bool shift = freeTilePosition == down || freeTilePosition == up;
    bool adjacent = freeTilePosition == right || freeTilePosition == left || shift;

    int destination = index > freeTilePosition ? freeTilePosition : freeTilePosition + 1;

    if(adjacent) {
        beginMoveRows(QModelIndex(), index, index, QModelIndex(), destination);
        m_tiles.swap(index, freeTilePosition);
        endMoveRows();

        if(shift) {
            int shiftDestination = index > freeTilePosition ? index + 1 : index;
            int shiftFrom = freeTilePosition == down ? down - 1 : up + 1;

            beginMoveRows(QModelIndex(), shiftFrom, shiftFrom, QModelIndex(), shiftDestination);
            endMoveRows();
        }
        return true;
    }
    return false;
}

void PlayBoardModel::appendTile(const Tile &tile)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_tiles.append(tile);
    endInsertRows();
}

void PlayBoardModel::clearModel()
{
    beginRemoveRows(QModelIndex(), 0, size() - 1);
    m_tiles.clear();
    endRemoveRows();
}

int getRandom (int i)
{
    return qrand() % i;
}

QVector<int> PlayBoardModel::generateRandomVector(int size) const
{
    QVector<int> randomVector;

    for(int i(0); i < size; ++i) {
        randomVector.push_back(i);
    }
    qsrand(QTime::currentTime().msec());
    std::random_shuffle(randomVector.begin(), randomVector.end(), getRandom);
    return randomVector;
}

bool PlayBoardModel::isSolvable()
{
    int pairs = 0;

    for(int i(0); i < size(); ++i) {
        if (m_tiles.at(i).value() != size() - 1) {
            for (int j(0); j < i; ++j) {
                if(m_tiles.at(j).value() > m_tiles.at(i).value()
                        && m_tiles.at(j).value() != size() - 1) {
                    ++pairs;
                }
            }
        } else {
            pairs += i / boardSize() + 1;
        }
    }
    return !(pairs % 2);
}

int PlayBoardModel::boardSize() const
{
    return m_boardSize;
}

int PlayBoardModel::size() const
{
    return m_boardSize * m_boardSize;
}

int PlayBoardModel::rowCount(const QModelIndex & parent) const
{
    Q_UNUSED(parent)
    return m_tiles.count();
}

QVariant PlayBoardModel::data(const QModelIndex & index, int role) const
{
    if (index.row() < 0 || index.row() >= m_tiles.count())
        return QVariant();

    const Tile &tile = m_tiles[index.row()];

    switch (role) {
    case ValueRole:
        return tile.value();
        break;
    default:
        return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> PlayBoardModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ValueRole] = "value";
    return roles;
}

