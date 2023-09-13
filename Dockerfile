FROM saladtechnologies/sdnext:latest


ENV CKPT=${DATA_DIR}/models/Stable-diffusion/DreamShaper_6_BakedVae.safetensors

# Get the model
RUN mkdir -p ${DATA_DIR}/models/Stable-diffusion/
RUN wget https://huggingface.co/Lykon/DreamShaper/resolve/main/DreamShaper_6_BakedVae.safetensors \
    -O ${CKPT}

ENV HOST='0.0.0.0'
ENV PORT=7860

ENTRYPOINT [  ]
CMD ["/bin/bash", "-c", "${INSTALLDIR}/entrypoint.sh \
    --use-cuda \
    --no-download \
    --docs \
    --ckpt ${CKPT} \
    --quick \
    --server-name \"${HOST}\" \
    --port ${PORT}" ]