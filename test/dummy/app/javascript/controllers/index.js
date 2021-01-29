import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'

import ocl_tools from 'ocl_tools'

const application = Application.start()
const context = require.context('controllers', true, /_controller\.js$/)

const context_list = definitionsFromContext(context)
context_list.push({'identifier': 'notice', 'controllerConstructor': ocl_tools.notice_controller})

application.load(context_list)
StimulusReflex.initialize(application, { consumer })
