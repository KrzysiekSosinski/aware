import { Then } from '@cucumber/cucumber';
import { getElementPath } from '../support/web-element-helper';
import { ElementKey } from '../../env/globals';
import { ScenarioWorld } from '../setup/world';
import { waitFor, waitForResult, waitForSelector } from '../support/wait-for-behavior';
import { getAttributeText } from '../support/html-behavior';

Then(
  /^the "([^"]*)" "([^"]*)" attribute should( not)? contain the text "(.*)"$/,
  async function(this: ScenarioWorld, elementKey: ElementKey, attribute: string, negate: boolean, expectedElementText: string) {
    const {
      screen: { page },
      globalConfig,
    } = this

    const elementIdentifier = getElementPath(page, elementKey, globalConfig)

    await waitFor(async () => {
        const elementStable = await waitForSelector(page, elementIdentifier)

        if (elementStable) {
          const attributeText = await getAttributeText(page, elementIdentifier, attribute)
          if (attributeText?.includes(expectedElementText) === !negate) {
            return waitForResult.PASS
          } else {
            return waitForResult.FAIL
          }
        } else {
          return waitForResult.ELEMENT_NOT_AVAILABLE
        }
      },
    )
  }
)
