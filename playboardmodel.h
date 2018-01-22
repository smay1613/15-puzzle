#ifndef PLAYBOARDMODEL_H
#define PLAYBOARDMODEL_H
#include <QAbstractListModel>

#include "tile.h"

class PlayBoardModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int boardSize READ boardSize CONSTANT)

public:
    enum TileRoles {
        ValueRole = Qt::UserRole + 1
    };

    PlayBoardModel(QObject *parent = nullptr);
    PlayBoardModel(int boardSize);

    Q_INVOKABLE bool isVictory();
    Q_INVOKABLE void shufflePlayBoard();
    Q_INVOKABLE bool playBoardMakeMove(int index);

    void clearModel();

    QVector<int> generateRandomVector(int size) const;

    bool isSolvable();

    int boardSize() const;
    int size() const;

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QHash<int, QByteArray> roleNames() const;

private:
    QList<Tile> m_tiles;
    int m_boardSize;
};

#endif // PLAYBOARDMODEL_H
