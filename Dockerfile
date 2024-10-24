FROM python

EXPOSE 8000

COPY ./TBDM-VGLS-2023/ObjectDetection /home/ObjectDetection
WORKDIR /home/ObjectDetection
COPY ./env ./fastapi_server/.env
COPY ./model_final.pth ./fastapi_server/obj_detection_model/model_final.pth
RUN apt update && apt install -y gcc g++ python3-dev python3-venv libgl1-mesa-dev

RUN python3 -m venv venv
RUN pip3 install wheel numpy cython 
RUN pip3 install -r requirements.txt
RUN pip3 install -r git_requirement.txt

WORKDIR /home/ObjectDetection/fastapi_server/

CMD [ "python", "main.py" ]
