from django.contrib import admin
from .models import UserModel, UserHobbyModel, UserHealthModel

# Define admin classes for more customized admin interface if needed
class UserModelAdmin(admin.ModelAdmin):
    list_display = ('id','email', 'pwd')  # Customize the list display to show these fields
    search_fields = ('email', 'pwd')  # Enable search by these fields

class UserHobbyModelAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'user', 'name', 'age', 'work', 'activities', 'mindfulness', 'mindfulnessTime', 'dedicateTime')
    search_fields = ('user__name', 'activities')  # Note the use of double underscore for searching by related field
    list_filter = ('mindfulness',)  # Enable filtering by the mindfulness field

class UserHealthModelAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'walkingSpeed', 'bvp', 'ecg', 'eda', 'temperature')


# Register your models here
admin.site.register(UserModel, UserModelAdmin)
admin.site.register(UserHobbyModel, UserHobbyModelAdmin)
admin.site.register(UserHealthModel, UserHealthModelAdmin)
