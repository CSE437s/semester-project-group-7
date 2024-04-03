from django.db import models

class UserModel(models.Model):
    email = models.CharField(max_length=200, null=True, blank=True, verbose_name="Email Address")
    pwd = models.CharField(max_length=200, null=True, blank=True, verbose_name="Password")


    class Meta:
        db_table = 'User'
        verbose_name = 'Authentication'
        verbose_name_plural = verbose_name

    def __str__(self):
        return f"{self.email}"

class UserHobbyModel(models.Model):
    user = models.ForeignKey(UserModel, on_delete=models.CASCADE, verbose_name="User Information")
    name = models.CharField(max_length=200, null=True, blank=True, verbose_name="Full Name")
    age = models.IntegerField(default=0, null=True, blank=True, verbose_name="Age")
    work = models.CharField(max_length=200, null=True, blank=True, verbose_name="Occupation")
    avatar = models.CharField(max_length=500, null=True, blank=True, verbose_name="Avatar")
    feel = models.CharField(max_length=500, null=True, blank=True, verbose_name="Emoji")
    activities = models.CharField(max_length=200, null=True, blank=True, verbose_name="Activities")
    mindfulness = models.BooleanField(default=False, null=True, blank=True, verbose_name="Practice Mindfulness?")
    mindfulnessTime = models.CharField(max_length=200, null=True, blank=True, verbose_name="Frequency")
    mindfulnessTopic = models.CharField(max_length=200, null=True, blank=True, verbose_name="Topics/Themes")
    dedicateTime = models.CharField(max_length=200, null=True, blank=True, verbose_name="Availability")
    extInfo = models.CharField(max_length=500, null=True, blank=True, verbose_name="Comment")

    class Meta:
        db_table = 'UserHobby'
        verbose_name = 'User Profile'
        verbose_name_plural = verbose_name

class UserHealthModel(models.Model):
    user = models.ForeignKey(UserModel, on_delete=models.CASCADE, verbose_name="User Information")
    walkingSpeed = models.FloatField(null=True, blank=True, verbose_name="Walking Speed")
    bvp = models.FloatField(null=True, blank=True, verbose_name="Blood Volume Pulse")
    ecg = models.FloatField(null=True, blank=True, verbose_name="Electrocardiography")
    eda = models.FloatField(null=True, blank=True, verbose_name="Electrodermal Activity")
    temperature = models.FloatField(null=True, blank=True, verbose_name="Temperature")

    class Meta:
        db_table = 'UserHealth'
        verbose_name = 'User Health'
        verbose_name_plural = verbose_name

    def __str__(self):
        return f"{self.user.email} Health Data"

