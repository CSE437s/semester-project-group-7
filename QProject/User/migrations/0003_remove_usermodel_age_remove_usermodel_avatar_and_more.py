# Generated by Django 5.0.3 on 2024-03-26 19:04

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("User", "0002_usermodel_pwd"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="usermodel",
            name="age",
        ),
        migrations.RemoveField(
            model_name="usermodel",
            name="avatar",
        ),
        migrations.RemoveField(
            model_name="usermodel",
            name="feel",
        ),
        migrations.RemoveField(
            model_name="usermodel",
            name="name",
        ),
        migrations.RemoveField(
            model_name="usermodel",
            name="work",
        ),
        migrations.AddField(
            model_name="userhobbymodel",
            name="age",
            field=models.IntegerField(
                blank=True, default=0, null=True, verbose_name="年龄"
            ),
        ),
        migrations.AddField(
            model_name="userhobbymodel",
            name="avatar",
            field=models.CharField(
                blank=True, max_length=500, null=True, verbose_name="头像"
            ),
        ),
        migrations.AddField(
            model_name="userhobbymodel",
            name="feel",
            field=models.CharField(
                blank=True, max_length=500, null=True, verbose_name="心情图片"
            ),
        ),
        migrations.AddField(
            model_name="userhobbymodel",
            name="name",
            field=models.CharField(
                blank=True, max_length=200, null=True, verbose_name="用户名"
            ),
        ),
        migrations.AddField(
            model_name="userhobbymodel",
            name="work",
            field=models.CharField(
                blank=True, max_length=200, null=True, verbose_name="职业"
            ),
        ),
    ]
