import json

from django.http import HttpResponse, JsonResponse
from rest_framework import serializers
from User.models import UserModel, UserHobbyModel



class UserModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserModel
        fields = '__all__'

def register(request):
    if request.method == "POST":
        json_dict = json.loads(request.body)
        email = json_dict.get('email')
        pwd = json_dict.get('pwd')
        try:
            if UserModel.objects.filter(email=email.strip()).count() > 0:
                return JsonResponse({
                    'status': 201,
                    'msg': '用户名已存在',
                    'results': ""
                })
            user = UserModel.objects.create(email=email, pwd=pwd)
            user_ser = UserModelSerializer(user, many=False).data
            return JsonResponse({
                'status': 0,
                'msg': 'success',
                'results': user_ser
            })
        except Exception as e:
            return JsonResponse({
                'status': 202,
                'msg': str(e),
                'results': ""
            })


def login(request):
    if request.method == "POST":
        json_dict = json.loads(request.body)
        email = json_dict.get('email')
        pwd = json_dict.get('pwd')
        print(email)
        print(pwd)

        # Check if the email exists in the database
        user = UserModel.objects.filter(email=email.strip()).first()
        print("finish filtering, not sure if user actually exist")
        
        if user:
            print("user exists")
            # Check if the password is correct
            if user.pwd == pwd.strip():
                user_ser = UserModelSerializer(user, many=False).data
                return JsonResponse({
                    'status': 0,
                    'msg': 'Login successful',
                    'results': user_ser
                })
            else:
                # Incorrect password
                return JsonResponse({
                    'status': 1,
                    'msg': 'Incorrect password',
                    'results': ""
                })
        else:
            print("user does not exist")
            # Email not found
            return JsonResponse({
                'status': 2,
                'msg': 'Email not found',
                'results': ""
            })



def hobby(request):
    if request.method == "POST":
        try:
            json_dict = json.loads(request.body)
            print(json_dict)
            uid = json_dict.get('id')    
            
            if uid:
                name = json_dict.get('name')
                age = json_dict.get('age')
                work = json_dict.get('work')
                avatar = json_dict.get('avatar')
                feel = json_dict.get('feel')



                activities = json_dict.get('activities')
                mindfulness = json_dict.get('mindfulness')
                mindfulnessTime = json_dict.get('mindfulnessTime')
                mindfulnessTopic = json_dict.get('mindfulnessTopic')
                dedicateTime = json_dict.get('dedicateTime')
                extInfo = json_dict.get('extInfo')


                UserHobbyModel.objects.create(user_id=uid, name=name, age=age, work=work, avatar=avatar, feel=feel, activities=activities, dedicateTime=dedicateTime,
                                              mindfulness=mindfulness, mindfulnessTime=mindfulnessTime,
                                              mindfulnessTopic=mindfulnessTopic, extInfo=extInfo)
                print("create succesfully")

                return JsonResponse({
                    'status': 0,
                    'msg': '保存成功',
                    'results': ""
                })
            else:
                return JsonResponse({
                    'status': 18,
                    'msg': "缺少必传用户id",
                    'results': ""
                })
        except Exception as e:
             return JsonResponse({
                'status': 13,
                'msg': str(e),
                'results': ""
            })
    return JsonResponse({
                'status': 10,
                'msg': '参数错误',
                'results': ""
            })
