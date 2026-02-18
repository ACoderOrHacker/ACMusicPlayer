#ifndef VERSIONQML_H
#define VERSIONQML_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include "version.h"

class MPlayerVersion : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString major READ getMajor)
    Q_PROPERTY(QString minor READ getMinor)
    Q_PROPERTY(QString patch READ getPatch)
    Q_PROPERTY(QString full  READ getFull)
public:
    explicit MPlayerVersion(QObject *parent = nullptr);

public:
    QString getMajor() const;
    QString getMinor() const;
    QString getPatch() const;
    QString getFull()  const;
};

#endif // VERSIONQML_H
