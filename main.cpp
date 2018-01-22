#include "playboardmodel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>

int main(int argc, char ** argv)
{
    QGuiApplication app(argc, argv);

    PlayBoardModel *model = new PlayBoardModel(4);

    QQmlApplicationEngine engine;
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("myModel", model);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
