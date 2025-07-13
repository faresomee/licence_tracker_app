from faker import Faker
import mysql.connector
import random
from datetime import datetime, timedelta
import os

fake = Faker('ar_AA')

conn = mysql.connector.connect(
    host="localhost",
    user="deuser",
    password="default@2025!",
    database="traffic_db",
    port=3307,
    charset="utf8mb4"
)
cursor = conn.cursor()

genders = ['ذكر', 'انثى']
statuses = ['عازب', 'مطلق', 'متزوج', 'ارملة']
religions = [
    'الإسلام',
    'المسيحية',
    'اليهودية',
    'البوذية',
    'الهندوسية',
    'السيخية',
    'البهائية',
    'الزرادشتية',
    'الطاوية',
    'الكونفوشيوسية',
    'الأرثوذكسية',
    'الكاثوليكية',
    'البروتستانتية',
    'المورمونية',
    'الشنتوية',
    'الجاينية',
    'الديانة الأفريقية التقليدية',
    'الوثنية',
    'الإلحاد',
    'اللاهوت المسيحي',
    'الروحانية',
]

def generate_male_name():
    with open("seed.male.txt","w", encoding="utf-8") as f:
        for _ in range(500):
            full_name = fake.name_male()
            f.write(f"{full_name}\n")
    print("تم إنشاء أسماء الذكور بنجاح.")


def generate_female_names():
    with open("seed.female.txt","w", encoding="utf-8") as f:
        for _ in range(500):
            full_name = fake.name_female()
            f.write(f"{full_name}\n")
    print("تم إنشاء أسماء الإناث بنجاح.")

with open("seed.male.txt", "r", encoding="utf-8") as f:
    male_names = [(line.strip(), 'ذكر') for line in f if line.strip()]

with open("seed.female.txt", "r", encoding="utf-8") as f:
    female_names = [(line.strip(), 'انثى') for line in f if line.strip()]


all_names = male_names + female_names


for full_name, gender in all_names:
    national_id = fake.unique.random_number(digits=14, fix_len=True)
    birth_date = fake.date_of_birth(minimum_age=18, maximum_age=70)
    status = random.choice(statuses)
    religion = random.choice(religions)
    address = fake.address().replace('\n', ' ')
    issue_date = fake.date_between(start_date='-10y', end_date='today')
    expired_date = issue_date + timedelta(days=3650)
    criminal_status = random.choice([True, False])

    print(f"Inserting: {full_name} ({gender})")

    sql = """
    INSERT INTO person (
        national_id, full_name, gender, date_of_birth,
        social_status, religion, address,
        issue_date, expired_date, criminal_status
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        str(national_id), full_name, gender, birth_date,
        status, religion, address,
        issue_date, expired_date, criminal_status
    )

    cursor.execute(sql, values)

# إنهاء الاتصال
conn.commit()
cursor.close()
conn.close()
