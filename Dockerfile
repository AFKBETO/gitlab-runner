ARG GITLAB_RUNNER_IMAGE_TYPE
ARG GITLAB_RUNNER_IMAGE_TAG
FROM gitlab/${GITLAB_RUNNER_IMAGE_TYPE}:${GITLAB_RUNNER_IMAGE_TAG}

RUN apt update && \
	apt upgrade && \
	apt install -y \
		build-essential \
		curl \
		wget \
		file \
		libxdo-dev \
		libssl-dev \
		libayatana-appindicator3-dev \
		librsvg2-dev \
		nsis llvm lld clang \
		nodejs &&\
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh && \
	source ~/.bash_profile && \
	corepack enable pnpm && \
	rustup target add x86_64-pc-windows-msvc

