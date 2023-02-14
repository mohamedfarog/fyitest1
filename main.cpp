
#include <QCommandLineParser>
#include <QDir>
#include <QIcon>
#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QGuiApplication::setWindowIcon(QIcon(":/FYILOGO1.svg"));
    QCoreApplication::setApplicationName("FyiTest");
    QCoreApplication::setOrganizationName("QtProject");
    QCoreApplication::setApplicationVersion(QT_VERSION_STR);
    QCommandLineParser parser;
    parser.setApplicationDescription("Qt Quick FyiTest");
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("url", "The URL(s) to open.");
    parser.process(app);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    if (!parser.positionalArguments().isEmpty()) {
        QUrl source = QUrl::fromUserInput(parser.positionalArguments().at(0), QDir::currentPath());
        QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                         [source](QObject *object, const QUrl &) {
                             qDebug() << "setting source";
                             object->setProperty("source", source);
                         });
    }
    engine.load(url);
    return app.exec();
}
