from steps.common_steps.common_environment import docker_setup


def before_all(context):
    docker_setup(context)
    context.build_or_pull_image(skip_pull=True, skip_build=True)
    context.mysql = {}


def after_scenario(context, scenario):
    context.remove_container()
